function [ ] = CreateTestResultFolder(TestName)
    DataFolder = strcat('Test results/',TestName);
    mkdir(DataFolder)
end

