function searchEmployeesByFirstName() {
    // Get the first name
    var firstNameSearchString = document.getElementById('firstNameSearch').value;
    // Construct the URL and redirect to it
    window.location = '/employees/search/' + encodeURI(firstNameSearchString);
}
