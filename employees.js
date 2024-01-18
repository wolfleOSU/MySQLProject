// Acquire needed employee info from database
module.exports = function() {
    var express = require('express');
    var router = express.Router();

    function getEmployees(res, mysql, context, complete) {
        mysql.pool.query("SELECT Ssn, Fname, Lname, Salary, Dno FROM EMPLOYEE", function(error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            } else {
                context.employees = results;
                complete();
            }
        });
    }

    // Get all projects from database to populate dropdown menu
    function getProjects(res, mysql, context, complete) {
        mysql.pool.query("SELECT Pnumber, Pname, Plocation, Dnum FROM PROJECT", function(error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            } else {
                context.projects = results;
                complete();
            }
        });
    }


    // function to select only employees who work on a certain project
    function getEmployeesByProject(req, res, mysql, context, complete) {
        var query = "SELECT E.Ssn, E.Fname, E.Lname, E.Salary, E.Dno FROM EMPLOYEE E INNER JOIN WORKS_ON W ON E.Ssn = W.Essn WHERE W.Pno = ?";
        var inserts = [req.params.projectId];
        mysql.pool.query(query, inserts, function(error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            } else {
                context.employees = results;
                complete();
            }
        });
    }


    // function to fetch only employees whose name contains a given string
    function searchEmployeesByName(req, res, mysql, context, complete) {
        var query = "SELECT Ssn, Fname, Lname, Salary, Dno FROM EMPLOYEE WHERE Fname LIKE " + mysql.pool.escape(req.params.name + '%');
        mysql.pool.query(query, function(error, results, fields) {
            if (error) {
                res.write(JSON.stringify(error));
                res.end();
            } else {
                context.employees = results;
                complete();
            }
        });
    }

    // Display all employees
    router.get('/', function(req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["filterEmployeesByProject.js", "searchEmployeesByName.js", "clearFilters.js"];
        var mysql = req.app.get('mysql');
        getEmployees(res, mysql, context, complete);
        getProjects(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('employees', context);
            }
        }
    });

    // Display employees filtered by project
    router.get('/filter/:projectId', function(req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["filterEmployeesByProject.js", "searchEmployeesByName.js", "clearFilters.js"];
        var mysql = req.app.get('mysql');
        getEmployeesByProject(req, res, mysql, context, complete);
        getProjects(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('employees', context);
            }
        }
    });

    // Search employees by name
    router.get('/search/:name', function(req, res) {
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["filterEmployeesByProject.js", "searchEmployeesByName.js", "clearFilters.js"];
        var mysql = req.app.get('mysql');
        searchEmployeesByName(req, res, mysql, context, complete);
        getProjects(res, mysql, context, complete);
        function complete() {
            callbackCount++;
            if (callbackCount >= 2) {
                res.render('employees', context);
            }
        }
    });

    return router;
}();
