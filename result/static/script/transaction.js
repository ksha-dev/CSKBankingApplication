var form;
function initialize() {
	form = document.getElementById('transaction-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	transactionTypeCheck();
	accountNumberCheck();
	amountCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());