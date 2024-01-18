function filterEmployeesByProject() {
    // Get the id of the selected project from the filter dropdown
    var projectId = document.getElementById('projectFilter').value;
    // Construct the URL and redirect to it
    window.location = '/employees/filter/' + parseInt(projectId);
}
