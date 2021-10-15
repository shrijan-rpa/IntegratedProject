public with sharing class SObjectHandler {
    
    public static SObject createNewSObject(String t) {
        // Call global describe to get the map of string to token.
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();

        // Get the token for the sobject based on the type.
        Schema.SObjectType st = gd.get(t);

        // Instantiate the sobject from the token.
        Sobject s = st.newSobject();

        return s; 
        }
}