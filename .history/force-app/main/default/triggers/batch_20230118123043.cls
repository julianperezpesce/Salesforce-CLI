Integer count = 0;
List<String> keys = new List<String>('Todos los id');

for(i = 0, i < keys.size(), i++) {
    count += 1;
    if(count < 200) {
        List<String> listaIds[i] = new List<String>('0011F00000tcEVQQA2');
        Id batchJobId = Database.executeBatch(new AccountRollupsImplementBatchFaltantes(listaIds[i]), 200);
    }
}

for(Integer i = 0 ; i < (keys.size() / 200)+1 ; i++){
    lstTemp = new List<Employee__c>();
    for(Integer j=(i*200);(j<(i*200)+200) && j<keys.size() ; j++){
        lstTemp.add(keys.get(j));
    }
    lstWrapper.add(lstTemp);
    Id batchJobId = Database.executeBatch(new AccountRollupsImplementBatchFaltantes(lstWrapper), 200);
}