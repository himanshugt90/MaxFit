public with sharing class searchRecords {
    @AuraEnabled
    public static String findRecords(String objName, String fieldName, String searchKey){
        String searchKeyword=searchKey+'*';
        String returningQuery=objName+'(Id,'+ fieldName+')';
        String Query = 'FIND :searchKeyword IN ALL FIELDS RETURNING '+returningQuery+' LIMIT 2000';
        List<List<SObject>> searchList=search.query(Query);
        return JSON.serialize(searchList);
    }
}
