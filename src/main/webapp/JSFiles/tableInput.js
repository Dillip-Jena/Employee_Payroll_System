$(document).ready(function () {
    $('#employeeTable').DataTable();

    // Save updated employee details
    $('.save-btn').click(function () {
        let row = $(this).closest('tr');
        let empId = row.data('id');
        let name = row.find('td:eq(2)').text().trim();
        let email = row.find('td:eq(3)').text().trim();
        let contact = row.find('td:eq(4)').text().trim();
        let address = row.find('td:eq(5)').text().trim();
        let joiningDate = row.find('td:eq(6)').text().trim();
        
        // Ensure joiningDate is valid before sending
        if (!/^\d{4}-\d{2}-\d{2}$/.test(joiningDate)) {
            alert("Invalid Date Format! Please enter date in YYYY-MM-DD format.");
            return;
        }

        $.ajax({
            url: contextPath + '/updateEmployeeServlet',
            type: 'POST',
            data: { empId, name, email, contact, address, joiningDate },
            success: function () {
                alert('Employee details updated successfully!');
            },
            error: function () {
                alert('Error updating employee details.');
            }
        });
    });

    // Delete employee
    $('.delete-btn').click(function () {
        let row = $(this).closest('tr');
        let empId = row.data('id');

        if (confirm('Are you sure you want to delete this employee?')) {
            $.ajax({
                url: contextPath + '/deleteEmployeeServlet',
                type: 'POST',
                data: { empId },
                success: function () {
                    row.remove();
                    alert('Employee deleted successfully!');
                },
                error: function () {
                    alert('Error deleting employee.');
                }
            });
        }
    });
});