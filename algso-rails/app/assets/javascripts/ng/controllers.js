var algsoCtrls = angular.module('algsoCtrls', []);

algsoCtrls.controller('appCtrl', function($scope,DataFormat) {
	$scope.flashNote = DataFormat.flashNote
})

algsoCtrls.controller('loginCtrl', function($http,$scope,Service,DataFormat) {
	// Email validation
	var regEmail = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{1,3}$/,
		regName = /^([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]$/,
		illegalName = ['create', 'home', 'search', 'info', 'center', 'store']

	// login/signup data
	$scope.userLoginData = DataFormat.userLoginData
	$scope.userSignupData = DataFormat.userSignupData

	// hint
	$scope.loginHintHidden = DataFormat.loginHintHidden
	$scope.signupHintHidden = DataFormat.signupHintHidden
	$scope.nameHintText = '' // 因为昵称的不合法提示有多个，因此提出来

	// submit enable
	$scope.enableLogin = false;
	$scope.enableSignup = false;

	// data change trigger
	$scope.checkEnableLogin = function() {
		var loginHintHidden = $scope.loginHintHidden,
			loginData = $scope.userLoginData,
			allInputValid = true

		// 所有input不为空
		angular.forEach(loginData, function(value, key){
			if(typeof value !== 'undefined' && value.length === 0){
				allInputValid = false
			} else if(typeof value === 'undefined'){
				loginData[key] = ""
			}
		})

		// 判断hint是否显示
		loginHintHidden.email = loginData.email.length === 0 || regEmail.test(loginData.email)
		loginHintHidden.password = loginData.password.length === 0 || loginData.password.length >= 6

		// 所有input合法
		angular.forEach(loginHintHidden, function(value, key){
			if(value === false){
				allInputValid = false
			}
		})

		// 判断submit按钮是否可用
		if (allInputValid) {
			$scope.enableLogin = true
		} else {
			$scope.enableLogin = false
		}

		if (!$scope.$$phase) {
			$scope.$apply()
		}
	}

	$scope.checkEnableSignup = function() {
		var signupHintHidden = $scope.signupHintHidden,
			signupData = $scope.userSignupData,
			allInputValid = true

		// 所有input不为空
		angular.forEach(signupData, function(value, key){
			if(value.length === 0){
				allInputValid = false
			} else if(typeof value === 'undefined'){
				loginData[key] = ""
			}
		})

		// 判断hint是否显示
		signupHintHidden.email = signupData.email.length === 0 || regEmail.test(signupData.email)
		signupHintHidden.name = signupData.name.length === 0 || 
								(signupData.name.length >= 2 &&
								 signupData.name.length <= 10 &&
								 illegalName.indexOf(signupData.name) === -1 &&
								 regName.test(signupData.name))
		signupHintHidden.password = signupData.password.length === 0 || signupData.password.length >= 6
		signupHintHidden.password_confirmation = signupData.password_confirmation.length === 0 || 
												 signupData.password_confirmation === signupData.password

		// 对昵称进行长度和合法性认证
		var inputName = signupData.name
		if(inputName.length < 2){
			$scope.nameHintText = "昵称长度不能小于2"
		} 
		if(inputName.length > 10) {
			$scope.nameHintText = "昵称长度不能大于10"
		}
		if(illegalName.indexOf(signupData.name) > -1 || !regName.test(inputName)){
			$scope.nameHintText = "请填写真实的名字"
		}

		// 所有input合法
		angular.forEach(signupHintHidden, function(value, key){
			if(value === false){
				allInputValid = false
			}
		})

		// 判断submit按钮是否可用
		if (allInputValid) {
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

		// 隐藏提示
		Service.hideFlashNote()

		// 上传
		if($scope.enableLogin){
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
	}

	$scope.signupSubmit = function() {
		// 组织数据
		var reqData = angular.copy($scope.userSignupData)

		// 隐藏提示
		Service.hideFlashNote()

		// 上传
		if($scope.enableSignup){
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