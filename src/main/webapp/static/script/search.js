var form;
function initialize() {
	form = document.getElementById('search-form');
	form.addEventListener('submit', (e) => submitValidation(e));
}

function submitValidation(e) {
	action = e;
	searchByCheck();
	searchValueCheck();
}

document.addEventListener('DOMContentLoaded', () => initialize());