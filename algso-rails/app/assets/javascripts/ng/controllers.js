var algsoCtrls = angular.module('algsoCtrls', []);

algsoCtrls.controller('loginCtrl', function($scope) {
	// Email validation
	var regEmail = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{1,3}$/

	// data
	$scope.userLoginData = {
		email: "",
		pwd: ""
	}

	$scope.userSignupData = {
		email: "",
		name: "",
		pwd: "",
		pwdConfirm: ""
	}

	// hint
	$scope.loginHint = {
		email: true,
		pwd: true
	}
	$scope.signupHint = {
		email: true,
		name: true,
		pwd: true,
		pwdConfirm: true
	}

	// submit enable
	$scope.enableLogin = false;
	$scope.enableSignup = false;

	// data change trigger
	$scope.checkEnableLogin = function() {
		var loginHint = $scope.loginHint

		loginHint.email = regEmail.test($scope.userLoginData.email)
		loginHint.pwd = $scope.userLoginData.pwd.length >= 6

		if (loginHint.email && loginHint.pwd) {
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
		signupHint.pwd = $scope.userSignupData.pwd.length >= 6
		signupHint.pwdConfirm = $scope.userSignupData.pwdConfirm === $scope.userSignupData.pwd

		if (signupHint.email && signupHint.name && signupHint.pwd && signupHint.pwdConfirm) {
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
	$scope.inputFocus = function(e){
		$scope.focusIn = e.target.name
    }
    $scope.inputBlur = function(){
    	$scope.focusIn = ""
    }

    //form link
    $scope.formLink = 'login'
    $scope.linkTo = function(link){
    	$scope.formLink = link
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
	console.log("ready")
}