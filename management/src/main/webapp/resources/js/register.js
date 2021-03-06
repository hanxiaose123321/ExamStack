$(function() {
	create_account.initial();
});

var create_account = {

	initial : function initial() {
		this.bindSubmitForm();
	},

	bindSubmitForm : function bindSubmitForm() {
		var form = $("form#form-create-account");

		form
				.submit(function() {
					var result = create_account.verifyInput();
					if (result) {
						var data = new Object();
						data.username = $("#name").val();
						data.email = $("#email").val();
						data.password = $("#password").val();
						data.fieldId = $("#job-type-input").val();
						jQuery
								.ajax({
									headers : {
										'Accept' : 'application/json',
										'Content-Type' : 'application/json'
									},
									type : "POST",
									url : form.attr("action"),
									data : JSON.stringify(data),
									success : function(message, tst, jqXHR) {
										if (message.result == "success") {
											document.location.href = document
													.getElementsByTagName('base')[0].href
													+ "regist-success/"
													+ data.username;
										} else {
											if (message.result == "duplicate-username") {
												$(
														".form-username .form-message")
														.text(
																message.messageInfo);
											} else if (message.result == "captch-error") {
												
											} else if (message.result == "duplicate-email") {
												$(
														".form-email .form-message")
														.text(
																message.messageInfo);
											} else {
												alert(message.result);
											}
										}
									}
								});
					}

					return false;
				});
	},

	verifyInput : function verifyInput() {
		$(".form-message").empty();
		var result = true;
		var check_u = this.checkUsername();
		var check_e = this.checkEmail();

		var check_p = this.checkPassword();
		var check_cp = this.checkConfirmPassword();
		var check_job = this.checkJob();

		
		result = check_u && check_e && check_p && check_cp && check_job;
		return result;
	},

	checkUsername : function checkUsername() {
		var username = $(".form-username input").val();
		if (username == "") {
			$(".form-username .form-message").text("?????????????????????");
			return false;
		} else if (username.length > 20 || username.length < 5) {
			$(".form-username .form-message").text("????????????5-20???????????????");
			return false;
		} else {
			var re=/[\+|\-|\\|\/||&|!|~|@|#|\$|%|\^|\*|\(|\)|=|\?|??|"|<|>|\.|,|:|;|\]|\[|\{|\}|\|]+/;
			if(re.test(username)){
				$(".form-username .form-message").text("?????????????????????????????????????????????");
				return false;
			}else return true; 
			
			
		}
		return true;
	},

	checkEmail : function checkEmail() {
		var email = $(".form-email input").val();
		if (email == "") {
			$(".form-email .form-message").text("??????????????????");
			return false;
		} else if (email.length > 40 || email.length < 5) {
			$(".form-email .form-message").text("????????????5-40???????????????");
			return false;
		} else {
			var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		   if(re.test(email)){
			   return true;
		   }else{
			   $(".form-email .form-message").text("???????????????");
				return false;
		   }
			
		}
		return true;
	},

	checkPassword : function checkPassword() {
		var password = $(".form-password input").val();
		if (password == "") {
			$(".form-password .form-message").text("??????????????????");
			return false;
		} else if (password.length < 6 || password.length > 20) {
			$(".form-password .form-message").text("??????????????????6???20???????????????");
			return false;
		} else {
			return true;
		}
		return true;
	},

	checkConfirmPassword : function checkConfirmPassword() {
		var password_confirm = $(".form-password-confirm input").val();
		var password = $(".form-password-confirm input").val();
		if (password_confirm == "") {
			$(".form-password-confirm .form-message").text("????????????????????????");
			return false;
		} else if (password_confirm.length > 20) {
			$(".form-password-confirm .form-message").text(
					"???????????????????????????20???????????????");
			return false;
		} else if (password_confirm != password) {
			$(".form-password-confirm .form-message").text("2????????????????????????");
			return false;
		} else {
			return true;
		}
	},
	checkJob : function(){
		var jobid = $("#job-type-input").val();
		if(jobid == -1){
			$(".form-job-type .form-message").text("???????????????");
			return false;
		}else{
			return true;
		}
		return false;
	},
	
	checkTerm : function checkTerm() {

		if ($('.form-confirm input[type=checkbox]').is(':checked')) {
			return true;

		} else {
			$(".form-confirm .form-message").text("?????????");
			return false;
		}
	}

};