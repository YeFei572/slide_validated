import os

# 获取文件夹名称
def getDirList( path):
    allList = os.listdir(path)
    for file in allList:
        filePath = os.path.join(path, file)
        if os.path.isdir(filePath):
            print(f'{filePath}\\')
            getDirList(filePath)

if __name__ == '__main__':
    getDirList(path='./')