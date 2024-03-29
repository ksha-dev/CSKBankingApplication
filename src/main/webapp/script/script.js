// document.addEventListener("DOMContentLoaded", function() {
//     var searchInput = document.getElementById('searchInput');
//     var table = document.getElementById('accountsTable');
//     var rows = table.getElementsByTagName('tr');

//     searchInput.addEventListener('keyup', function() {
//         var searchTerm = this.value.toLowerCase();
//         Array.from(rows).forEach(function(row) {
//             var accountNumber = row.getElementsByTagName('td')[0];
//             if (accountNumber) {
//                 var textValue = accountNumber.textContent || accountNumber.innerText;
//                 if (textValue.toLowerCase().indexOf(searchTerm) > -1) {
//                     row.style.display = '';
//                 } else {
//                     row.style.display = 'none';
//                 }
//             }
//         });
//     });
// });


function logout() {
	var confirmation = confirm("Press OK to confirm logout.\nPress Cancel or escape to cancel");
	if (confirmation) {
		location.href = "app?route=logout";
	}
}

function transferDialog() {
	var confirmation = confirm("Do not close or press back from the next screen. Confirm Trasfer");
	if (confirmation) {
		// console.log("Trasaction Initiated");
		location.href = "../../html/authorization.html"
	}
}

function confirmUpdate() {
	var confirmation = confirm("Click ok to confirm update");
	if (confirmation) {
		// console.log("Trasaction Initiated");
		location.href = "../../html/profile.html"
	}
}

// const selectField = document.getElementById('selectField');
// const optionalField = document.getElementsByClassName('optional-field');

// selectField.addEventListener('change', function () {
//     console.log('change');
//     // Hide all option fields
//     optionalField.style.display = 'none';

//     // Show input fields based on selected option
//     const selectedOption = selectField.value;
//     if (selectedOption === 'true') {
//         optionalField.style.display = 'block';
//     }
// });