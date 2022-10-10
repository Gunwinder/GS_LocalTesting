public class CloneAttachmentToFilesUtil {

    public static void convertAttachment(Set<Id> parentIdsSet){
        Savepoint sp = Database.setSavepoint(); 
        List<Attachment> lstAttachment = [SELECT Id, ParentId, Name,Description, CreatedById,
                                          CreatedDate, LastModifiedById, LastModifiedDate, 
                                          OwnerId, isPrivate, Body 
                                          FROM Attachment where 
                                          ParentId IN:parentIdsSet 
                                          LIMIT 10000];
        try{
            Map<Id, List<Blob>> mapAttachmentIdLstBlob = new Map<Id, List<Blob>>();
            Map<Id, Attachment> mapIdAttachment = new Map<Id, Attachment>();
            for(Attachment attach: lstAttachment){
                String bodyCont = attach.Body!=null ? String.valueOf(attach.Body).replace('&','&amp;')
                                                 .replace('<','&lt;').replace('>','&gt;')
                                                 .replace('"','&quot;').replace('\'','&#39;'):'.';
                Blob tmpBlob = Blob.valueOf(bodyCont);
                if(!mapAttachmentIdLstBlob.containsKey(attach.Id)){
                    mapAttachmentIdLstBlob.put(attach.Id, new List<Blob>());
                }
                mapAttachmentIdLstBlob.get(attach.Id).add(tmpBlob);
                mapIdAttachment.put(attach.Id, attach);
            }
            
            Map<Id, List<ContentVersion>> mapActIdLstCV = 
                    createContentVersionAttachment(mapAttachmentIdLstBlob, mapIdAttachment);
            List<ContentDocumentLink> lstCVDL = updateContentDocLink(mapActIdLstCV);
        }Catch(Exception ex){
            Database.rollback(sp);
            System.debug('Error-> '+ex.getLineNumber()+' Message : '+ex.getMessage());
            throw ex;
        }
    }
    
    public static void convertNotes(Set<Id> parentIdsSet){
        List<Note> lstNot = [SELECT Id, ParentId, Title, Body FROM Note where 
                             ParentId IN:parentIdsSet LIMIT 10000];
        try{
            Map<Id, List<Blob>> mapNoteIdLstBlob = new Map<Id, List<Blob>>();
            Map<Id, Note> mapIdNote = new Map<Id, Note>();
            for(Note n: lstNot){
                String bodyCont = n.Body!=null ? String.valueOf(n.Body).replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;').replace('\'','&#39;'):'.';
                Blob tmpBlob = Blob.valueOf(bodyCont);
                if(!mapNoteIdLstBlob.containsKey(n.Id)){
                    mapNoteIdLstBlob.put(n.Id, new List<Blob>());
                }
                mapNoteIdLstBlob.get(n.Id).add(tmpBlob);
                mapIdNote.put(n.Id, n);
            }
            
            Map<Id, List<ContentVersion>> mapActIdLstCV = createContentVersion(mapNoteIdLstBlob, mapIdNote);
            List<ContentDocumentLink> lstCVDL = updateContentDocLink(mapActIdLstCV);
        }Catch(Exception e){
            
        }
    }
    
    public static List<ContentDocumentLink> updateContentDocLink(Map<Id, List<ContentVersion>>  actIdLstCVMap){
        Set<String> cvSet = new Set<String>();
        Map<Id, Id> cvIdMap = new Map<Id, Id>();
        for(Id accId: actIdLstCVMap.KeySet()){
            for(ContentVersion cv: actIdLstCVMap.get(accId)){
                cvSet.add(cv.Id);
                cvIdMap.put(cv.Id, accId);
            }
        }
        List<ContentVersion> cvLst = [SELECT ContentDocumentId FROM ContentVersion WHERE (Id IN :cvSet)];
        List<ContentDocumentLink> cdlLst = new List<ContentDocumentLink>();
        for(ContentVersion cv: cvLst){
            ContentDocumentLink cdl 	= new ContentDocumentLink(); 
            cdl.ContentDocumentId 		= cv.ContentDocumentId; 
            cdl.LinkedEntityId 			= cvIdMap.get(cv.Id); 
            cdl.ShareType 				= 'I'; 
            cdlLst.add(cdl);
        }
        INSERT cdlLst;
        return cdlLst;
    }
    public static Map<Id, List<ContentVersion>> createContentVersion(Map<Id, List<Blob>> mapNoteIdLstBlob, 
                                                                     Map<Id, Note> mapIdNote){
        Map<Id, List<ContentVersion>> retMap = new Map<Id, List<ContentVersion>>();
        List<ContentVersion> lstCV = new List<ContentVersion>();
        for(Id noteId : mapNoteIdLstBlob.keySet()){
            List<Blob> noteBlob = mapNoteIdLstBlob.get(noteId);
            for(Blob b:noteBlob){
                ContentVersion cv   = new ContentVersion();
                cv.ContentLocation  = 'S';
                cv.VersionData 		= b;
                cv.CreatedById 		= mapIdNote.get(noteId).CreatedById;
                cv.Title 			= mapIdNote.get(noteId).Title;  
                cv.PathOnClient 	= mapIdNote.get(noteId).Title+'.snote';              
                lstCV.add(cv);
                if(!retMap.containsKey(mapIdNote.get(noteId).ParentId)){
                    retMap.put(mapIdNote.get(noteId).ParentId,new List<ContentVersion>());    
                }
                retMap.get(mapIdNote.get(noteId).ParentId).add(cv);    
            }
        }
        INSERT lstCV;
        return retMap;
    }
    
     public static Map<Id, List<ContentVersion>> createContentVersionAttachment(Map<Id, List<Blob>> mapNoteIdLstBlob, 
                                                                     Map<Id, Attachment> mapAttachment){
                                                                         
        Savepoint sp = Database.setSavepoint();                                                        
        Map<Id, List<ContentVersion>> contentVersionMap = new Map<Id, List<ContentVersion>>();
        List<ContentVersion> newFileVersionList = new List<ContentVersion>();
                
        for(Id attachmentId : mapNoteIdLstBlob.keySet()){
            List<Blob> noteBlob = mapNoteIdLstBlob.get(attachmentId);
            for(Blob b:noteBlob){
                ContentVersion newFileVersion = new ContentVersion(
                    versionData 			 = mapAttachment.get(attachmentId).body,
                    title 				     = mapAttachment.get(attachmentId).name,
                    description 			 = mapAttachment.get(attachmentId).description,
                    pathOnClient 			 = '/' + mapAttachment.get(attachmentId).name,
                    firstPublishLocationId   = mapAttachment.get(attachmentId).parentId,
                    sharingPrivacy 			 = ( mapAttachment.get(attachmentId).isPrivate ? 'P' : 'N' ),
                    createdById 			 = mapAttachment.get(attachmentId).ownerId,
                    createdDate 			 = mapAttachment.get(attachmentId).createdDate,
                    lastModifiedById 		 = mapAttachment.get(attachmentId).lastModifiedById,
                    lastModifiedDate	     = mapAttachment.get(attachmentId).lastModifiedDate
                    //Original_Record__c = mapAttachment.get(attachmentId).id,
                    //Parent_Id__c = mapAttachment.get(attachmentId).parentId
                );             
                newFileVersionList.add(newFileVersion);
                if(!contentVersionMap.containsKey(mapAttachment.get(attachmentId).ParentId)){
                    contentVersionMap.put(mapAttachment.get(attachmentId).ParentId,new List<ContentVersion>());    
                }
                contentVersionMap.get(mapAttachment.get(attachmentId).ParentId).add(newFileVersion);    
            }
        }
        try{
            Database.DMLOptions dmlOptions = new Database.DMLOptions();
            dmlOptions.OptAllOrNone = false;
            
            List<Database.SaveResult> saveReultRecords = Database.insert(newFileVersionList, dmlOptions);
            For(Database.SaveResult sr : saveReultRecords){
                if(sr.isSuccess()){
                    
                }else if(!sr.isSuccess()){
                    
                }
            }
            return contentVersionMap;
        }catch(Exception ex){
            Database.rollback(sp);
            throw ex;
        }
    }
}