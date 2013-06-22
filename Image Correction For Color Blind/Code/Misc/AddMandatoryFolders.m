function [] = AddMandatoryFolders()
%{
Summary

    Add the necessery folders and subfolders to project searching paths.
	The function gets the necessery folders from the configuration file which available in this folder.
	To add more folders to the searching path of matlab in the future, just add the folder to the configuration file. 


%}

% Read the xml file
try
   tree = xmlread('ConfigurationFile.xml');
catch
   error('Failed to read XML file %s.',filename);
end

   %Get the mandatory folders node
   MandatoryFoldersNode = tree.getElementsByTagName('MandatoryFolderPaths');
   MandatoryFoldersNode = MandatoryFoldersNode.item(0);

   % Get the list of folders that we need to add to path
   folders = MandatoryFoldersNode.getElementsByTagName('folder');
   
   %Iterate over all folders
   for i = 0:folders.getLength-1
       
       %Retrive the folder path from the xml node
       folderPath = folders.item(i).getFirstChild.getData;
       
       %Add folder to searching paths
       addpath(genpath(char(folderPath)));
   end
   
end