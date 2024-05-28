var form;
var customDateWidget;
function initialize() {
	form = document.getElementById('statement-form');
	form.addEventListener('submit', (e) => submitValidation(e));
	customDateWidget = document.getElementById("customDates");

	const startDate = document.getElementById('startDate');
	const endDate = document.getElementById('endDate');
	var currentDate = new Date();

	var currentDateString = currentDate.toISOString().split('T')[0];

	startDate.max = currentDateString;
	endDate.max = currentDateString;
}

function triggerTransactionLimit() {
	if ($("#transactionLimit").val() === "custom") {
		customDateWidget.style.display = "block";
	} else {
		customDateWidget.style.display = "none";
	}
}

function submitValidation(e) {
	action = e;
	accountNumberCheck();
	transactionLimitCheck();

	if ($("#transactionLimit").val() === "custom") {
		customDateCheck();
	}
}

document.addEventListener('DOMContentLoaded', () => initialize());