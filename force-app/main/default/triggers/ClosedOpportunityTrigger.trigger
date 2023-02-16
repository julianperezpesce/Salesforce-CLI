trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskList = new List<Task>();

    for (Opportunity opp : [
        SELECT Id, Name FROM Opportunity 
        WHERE StageName='Closed Won' AND Id IN :Trigger.New]) {
            taskList.add(new Task(
                Subject = 'Tarea de prueba de seguimiento',
                WhatId = opp.Id
                )                
            );
        }
    if(taskList.size() > 0) {
        insert taskList;
    }
}