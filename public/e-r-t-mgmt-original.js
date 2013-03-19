var employees = [{
    "name":"akhil",
    "search":"0"
}, {
    "name":"hk",
    "search":"0"
}, {
    "name":"rd",
    "search":"0"
}, {
    "name":"alok",
    "search":"0"
}, {
    "name":"kashish",
    "search":"0"
}, {
    "name":"ashish",
    "search":"0"
}, {
    "name":"jatin",
    "search":"0"
}, {
    "name":"kapil",
    "search":"0"
}];
var roles = [{
    "id":"0",
    "name":"ROR Developer"
},{
    "id":"1",
    "name":"JS/JQuery"
},{
    "id":"2",
    "name":"Android"
}]

$( function() {
    var employeeTable = $('#employees');
    var rolesTable = $('#roles');
    var toDoTable = $('#to-dos');
    var deleteImage = $('<img src=delete.png></img>');
    fillEmployees();
    function fillEmployees() {
        employeeTable.html('<h1>Employees</h1>');
        //fill up the employee table
        $.each(employees, function(i, item) {
            var emploDiv = $("<div></div>");
            emploDiv.addClass( assignClass(i) );
            var p = $('<p draggable=true>' + item["name"] + '</p>'); 
            var image = deleteImage.clone();
            image.addClass('delete');
            image.click( function() {
                if(confirm("Are you sure?")) {
                    removeEmployee( item, 0, i);
                    rolesTable.find('a').click();
                    $('img#to-do-show').click();
                    emploDiv.remove();
                }
            });
            emploDiv.append(image);
            image.hide();
            image.hover( function() {
                image.show();
            });
            emploDiv.hover( function() { 
                image.show();
            },
              function () {
                image.hide();
              }
            );
            emploDiv.append(p);
            employeeTable.append(emploDiv);
        });
        function assignClass ( index ) {
            if( index % 2 == 0 ) {
                return ('employee0')
            }
            else {
                return ('employee1');
            }
        }
        //make all the paras in the employee table draggable
        $('div#employees p').draggable({ 
                helper : 'clone'
        });        
    }
    
    //fill up the role table and to-do table
    $.each(roles, function(i, item) {
        var roleName = item["name"];
        addRole(roleName);
        $.each(employees, function(i, emp) {
            emp[roleName] = "0";
        });
        //create a div for each role containing the headings,maximize and minimize image
        var toDoDiv = $('<div align=center class=to-dos ></div>');
        var headingsDiv = $('<div class=toDoHeading>' + item["name"] + '</div>');
        var maximizeImage = $("<img class=max src='plus.png'></img>");
        var minimizeImage = $("<img class='min hidden' src='mini.png'></img>");
        headingsDiv.append(minimizeImage);
        headingsDiv.append(maximizeImage);
        toDoDiv.append(headingsDiv);
        //click function on maximize image
        maximizeImage.click(function name() {
            toDoDiv.find('div.empToDo').remove();
            $.each(employees, function(index, employee) {
                if( employee[roleName][0] == 1 ) {
                      toDoDiv.append(addToDoEmployee(employee, roleName, index));    
                }
            });
            //show the other image and hide the current one
            $(this).siblings('img').removeClass('hidden');
            $(this).addClass('hidden');
        });
        //click function on minimize image
        minimizeImage.click( function() {
            toDoDiv.find('div.empToDo').slideUp();
            $(this).siblings('img:hidden').removeClass('hidden');
            $(this).addClass('hidden');
        });
        //append it in the toDoTable #to-dos
        toDoTable.append(toDoDiv);
        
        //function to add an employee under a role in to-do column
        function addToDoEmployee(employee, roleName, index) {
            var $newDiv = $('<div class=empToDo ></div>');
            var $nameDiv = $('<div class=name><p>' + employee["name"] + '</p></div>');
            $newDiv.append($nameDiv);
            //to apply the animate effect incase it is the searched employee accoording to the number of to-dos
            if(employee[roleName]["search"] == "1" ) {
                animateNameDiv($nameDiv);
                employee[roleName]["search"] = "0";
            }
            
            var $taskDiv = $("<div class=tasks style=float:left;></div>");
            // in case the employee has been assigned tasks add assigned to-dos
            $.each(employee[roleName],function( toDoIndex) {
                if( toDoIndex != 0 ) {
                    var assignedToDoDiv = appendAssignedToDo( this, employee, roleName, toDoIndex );
                    $taskDiv.append( assignedToDoDiv);
                }
            });
            //add an empty to-do
            var $emptyToDo = appendEmptyToDo(employee, roleName);
            $taskDiv.append($emptyToDo);
            $newDiv.append($taskDiv);
            return $newDiv;
        }
        //function to append an assigned to-do
        function appendAssignedToDo( assignedTask, employee, roleName, toDoIndex ) {
            var tempDiv = $('<div><p>'+assignedTask+'</p></div>');
            var inputBox = $("<input type=text></input>");
            var imageIconEdit = $("<img src='edit-icon.png'></img>");
            var imageIconDelete = deleteImage.clone();
            imageIconDelete.click(function() {
                employee[roleName].splice(toDoIndex,1);
                maximizeImage.click();
            });
            var imageIconSave = $("<img class='hidden' src='save-icon.png' ></img>");
            imageIconSave.click( function () {
                var toDoText = inputBox.val().trim();
                if( toDoText.length > 0 ) {
                    employee[roleName][toDoIndex] = inputBox.val();
                }
                else {
                    alert("empty To-Do");
                }
                maximizeImage.click();
            });
            imageIconEdit.click( function() {
                var textField = tempDiv.find('p');
                inputBox.val(textField.text());
                inputBox.insertAfter(textField);
                textField.hide();
                imageIconDelete.addClass('hidden');
                imageIconSave.removeClass('hidden');
            });
            
            //tempDiv.append(inputBox);
            tempDiv.append( imageIconEdit );
            tempDiv.append( imageIconSave );
            tempDiv.append( imageIconDelete );
            return tempDiv;
        }
        //function to append an empty to-do
        function appendEmptyToDo (employee, roleName) {
            var tempDiv = $('<div class=tasks></div>');
            var inputBox = $("<input type=text value='Add a new To-Do here'></input>");
            var imageIcon = $("<img src='save-icon.png' style='height:19px;width:20px;'></img>");
            imageIcon.click( function() {
                var toDo = inputBox.val().trim();
                if(toDo.length > 0) {
                    employee[roleName].push(inputBox.val());;
                }
                maximizeImage.click();
                
            });
            tempDiv.append(inputBox);
            tempDiv.append( imageIcon );
            return tempDiv;        
        }
        //function to apply animation
        function animateNameDiv( nameDiv ) {
            for( var j = 0; j < 5; j ++) {
                nameDiv.fadeTo('slow', 0.0).fadeTo('slow', 2.0);
            }
        }
        
    });
    //function to add a new role in the roles table
    function addRole( roleName ) {
        var roleDiv = $( '<div class=roles></div>' );
        var anchorTag = $( "<a class=draganchor href=''>" + roleName + "</a>" );
        anchorTag.after($('<div class=assignedemp></div>') );
        anchorTag.click( function( ) {
            var parentDiv = $(this).siblings( 'div.assignedemp' );
            parentDiv.html('');
            //find all the employees assigned under a particular role
            $.each(employees, function (index, employee) {
                if( employee[roleName][0] == 1) {
                    var empDiv = addEmpUnderRole(employee, roleName, anchorTag);
                    empDiv.addClass('employee' + ( (index % 2 == 0) ? 0: 1 )) 
                    parentDiv.append(empDiv);
                }              
            });
            
            parentDiv.hide();
            parentDiv.slideDown();            
            return false;
        });
        roleDiv.append(anchorTag);
        rolesTable.append(roleDiv);
    }
    //function to remove employee from a particular role
    function removeEmployee( employee, roleName, index ) {
        if( index != undefined ) {
            employees.splice(index, 1);
        }
        else
        employee[roleName][0] =  0 ;
    }
    //function to add employee under a particular role in role table
    function addEmpUnderRole(employee, roleName, anchorTag) {
        var empDiv = $('<div align=left class=empinrole><p>' + employee["name"] + '<p></div>');
        var image = deleteImage.clone();
        image.addClass( 'delete' );
        image.click( function() {
            if( confirm("Are you sure?") ) {
                removeEmployee(employee, roleName);
                anchorTag.click();
                $('img#to-do-show').click();
            }
        });
        empDiv.append(image);
        image.hide();
        image.hover( function() {
            image.show();
        });
        empDiv.hover( function() { 
            image.show();
        },
          function () {
            image.hide();
          }
        );
        return empDiv;
    }
    
    //make the role div droppable and assign the drop label in it
    $('div.roles').droppable ({
        drop : function( event, ui ) {
            var anchor = $(this).find('a');
            var category = anchor.text();
            $.each(employees, function (index, emp) {
                if( emp["name"] == ui.helper.text()) {
                    emp[category] = [1];
                    $('img#to-do-show').click();
                }
            });
            anchor.click();
        }
    });
    
    //task for the maximize image click on the to-do table
    $('img#to-do-show').click( function() {
        $('div.to-dos img.max').click();
    });
    //task for the minimize image on the to-do table
    $('img#to-do-hide').click( function() {
        $('div.to-dos img.min').click();
    });
    
    //function on the click of search button
    $('#searchdiv input:button').click(function() {
        var toDoNumber = parseInt($(this).siblings('input:text').val(), 10);
        $.each(employees,function(index, employee) {
           $.each(roles, function(i, role) {
              if((employee[role["name"]].length - 1) == toDoNumber) {
                  employee[role["name"]]["search"] = "1";
              }
              else{
              employee[role["name"]]["search"] = "0";
              }
           }); 
        });
        $('img#to-do-show').click();
    });
});
