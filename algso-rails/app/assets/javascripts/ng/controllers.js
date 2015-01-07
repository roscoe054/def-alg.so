var algsoCtrls = angular.module('algsoCtrls', []);

algsoCtrls.controller('appCtrl', function($scope,DataFormat) {
	$scope.flashNote = DataFormat.flashNote
})

algsoCtrls.controller('loginCtrl', function($http,$scope,Service,DataFormat) {
	// Email validation
	var regEmail = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{1,3}$/,
		regName = /^([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]$/

	// login/signup data
	$scope.userLoginData = DataFormat.userLoginData
	$scope.userSignupData = DataFormat.userSignupData

	// hint
	$scope.loginHint = DataFormat.loginHint
	$scope.signupHint = DataFormat.signupHint

	// submit enable
	$scope.enableLogin = false;
	$scope.enableSignup = false;

	// data change trigger
	$scope.checkEnableLogin = function() {
		var loginHint = $scope.loginHint

		loginHint.email = regEmail.test($scope.userLoginData.email)
		loginHint.password = $scope.userLoginData.password.length >= 6

		if (loginHint.email && loginHint.password) {
			$scope.enableLogin = true
		} else {
			$scope.enableLogin = false
		}

		if (!$scope.$$phase) {
			$scope.$apply()
		}
	}

	$scope.checkEnableSignup = function() {
		var signupHint = $scope.signupHint

		signupHint.email = regEmail.test($scope.userSignupData.email)
		signupHint.name = $scope.userSignupData.name.length >= 2
		signupHint.password = $scope.userSignupData.password.length >= 6
		signupHint.password_confirmation = $scope.userSignupData.password_confirmation === $scope.userSignupData.password

		if (signupHint.email && signupHint.name && signupHint.password && signupHint.password_confirmation) {
			$scope.enableSignup = true
		} else {
			$scope.enableSignup = false
		}

		if (!$scope.$$phase) {
			$scope.$apply()
		}
	}

	// focus
	$scope.focusIn = ''
	$scope.inputFocus = function(e) {
		$scope.focusIn = e.target.name
	}
	$scope.inputBlur = function() {
		$scope.focusIn = ""
	}

	// form link
	$scope.formLink = location.pathname === "/signup" ? 'signup' : 'login'
	$scope.linkTo = function(link) {
		$scope.formLink = link
		Service.hideFlashNote()
		history.replaceState(null, "", link);
	}

	// login/signup submit
	$scope.loginSubmit = function() {
		// 组织数据
		var reqData = angular.copy($scope.userLoginData)

		// 上传
		$http({
			url: "http://" + location.host + '/api/login',
			data: reqData,
			method: "POST"
		}).success(function(data) {
			if(data.req === "success"){
				location.href = "/user/" + data.name_id
			} else{
				Service.showFlashNote(data.req, data.info)
			}
		})
	}

	$scope.signupSubmit = function() {
		// 组织数据
		var reqData = angular.copy($scope.userSignupData)

		// 上传
		$http({
			url: "http://" + location.host + '/api/signup',
			data: reqData,
			method: "POST"
		}).success(function(data) {
			if(data.req === "success"){
				location.href = "/"
			} else{
				Service.showFlashNote(data.req, data.info)
			}
		})
	}

	ReserveCtrlReady($scope)
})

// document ready
function ReserveCtrlReady($scope) {
	angular.element(document).ready(function() {
		// 等待浏览器自动填充之后对填充数据进行校验
		setTimeout(function() {
			$scope.checkEnableLogin()
		}, 200)
	});
}