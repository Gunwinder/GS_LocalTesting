public class AssetsMain   {
    LIST<Asset> AMain =[SELECT Id, Name, SerialNumber,Price,Status from Asset]; // Consolidated query.
    
    LIST<Asset> AMain_Shipped =[SELECT Id, Name, SerialNumber,Price,Status from Asset WHERE Status='Shipped']; 
    // Restricted by Shipped Status, double quotes are not acceptable, instead use single quote in where caluse.
    
    LIST<Asset> AMain_Registered =[SELECT Id, Name, SerialNumber,Price,Status from Asset WHERE Status='Registered']; 
    // Restricted by Registered Status, double quotes are not acceptable, instead use single quote in where caluse.
    
    
    // public method. 
    public LIST<Asset> getAMain(){ // do not forget to add get
    return AMain;
    }
    
    public LIST<Asset> getAMain_Shipped(){ // Separate method is needed based on SOQL query, do not forget to add get
    return AMain_Shipped;
    }
    
    public LIST<Asset> getAMain_Registered(){ // Separate method is needed based on SOQL query, do not forget to add get
    return AMain_Registered;
    }
    
    
}