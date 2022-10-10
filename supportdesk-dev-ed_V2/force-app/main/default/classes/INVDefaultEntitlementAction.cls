/* https://www.desynit.com/dev-zone/salesforce-development/replacing-apex-triggers-processes-invocable-actions/ */

public class INVDefaultEntitlementAction {
    @InvocableMethod(label='Update Default Entitlements' description='Determines the default Entitlement for the Case and returns the updated Cases.')
    public static void updateDefaultEntitlements(List<Case> casesToUpdate) {
        List<Case> cases = [
            SELECT AccountId, EntitlementId, AssetId 
            FROM Case 
            WHERE Id IN:new Map<Id, Case>(casesToUpdate).keySet()
        ];
        
        Set<Id> accountIds = new Set<Id>();
            
        for (Case c : cases){
            if (c.EntitlementId == null && c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }

        if(accountIds.size() > 0) {    
            List <Entitlement> entitlements = [
                SELECT StartDate, EndDate, AccountId, AssetId
                FROM Entitlement
                WHERE AccountId in :accountIds 
                    AND StartDate <= TODAY 
                    AND EndDate >= TODAY
            ];
            
            if(entitlements.size() > 0) {       
                Map<Id, Entitlement> entitlementsByAccountId = new Map<Id, Entitlement>();
                
                for(Entitlement e : entitlements) {
                    entitlementsByAccountId.put(e.AccountId, e);
                }
                
                for(Case c : cases){
                    if(c.EntitlementId == null && c.AccountId != null) {
                        Entitlement e = entitlementsByAccountId.get(c.AccountId);
                        
                        if(e != null) {
                            c.EntitlementId = e.Id;
                            
                            if(c.AssetId == null && e.AssetId != null) {
                                c.AssetId = e.AssetId;
                            }
                        }
                    }
                }
                
                update cases;
            }
        }
    }
}