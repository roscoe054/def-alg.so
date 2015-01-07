var algsoFactories = angular.module('algsoFactories', []);

algsoFactories.factory('DataFormat', function() {
	return {
		flashNote: {
			hidden: true,
			type: '',
			info: ''
		},
		userLoginData: {
			email: '',
			password: '',
			remember: false
		},
		userSignupData: {
			email: '',
			name: '',
			password: '',
			password_confirmation: ''
		},
		loginHint: {
			email: true,
			password: true
		},
		signupHint: {
			email: true,
			name: true,
			password: true,
			password_confirmation: true
		}
	}
})

algsoFactories.factory('Service', function(DataFormat) {
	var service = {}

	service.showFlashNote = function(type, info) {
		var flashNote = DataFormat.flashNote

		flashNote.type = type
		flashNote.info = info
		flashNote.hidden = false
	}

	service.hideFlashNote = function() {
		var flashNote = DataFormat.flashNote

		flashNote.type = ''
		flashNote.info = ''
		flashNote.hidden = true
	}

	return service
})