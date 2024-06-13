var form;
function initialize() {
	form = document.getElementById('transfer-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	fromAccountCheck();
	toAccountCheck();
	amountCheck();
	remarksCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());