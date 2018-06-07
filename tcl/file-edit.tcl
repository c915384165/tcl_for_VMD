# 文件测试
file exists $name        ; # 判断文件是否**存在** 
file isdirectory $name   ; # 判断文件是否是**目录** 
file isfile $name        ; # 判断文件是否是**文件** 
file readable $name      ; # 判断文件是否**可读** 
file writable $name      ; # 判断文件是否**可写**
file executable $name    ; # 判断文件是否**可执行** 

# 文件路径、文件名
set name /path/a/b/c.txt
file extension $name ; #   .txt 
file dirname $name               ; #  /path/a/b
file rootname $name              ; #  /path/a/b/c 
file tail $name                  ; # c.txt
file nativename $name            ; # 系统默认格式的文件名 windows X:\path\a\b\c

# 文件信息
set name /path/a/b/c.txt
file size $name        ; # 单位 字节（bytes）
file stat $name finfo
array get finfo *      ; # {atime, ctime, dev, gid, ino, mode, mtime, nlink, size, type, uid}  
file separator         ; # 系统支持的文件路径分隔符 windows \

# 文件操作
file mkdir $name              ; # mkdir -p $name  创建目录，自动创建父目录  
file copy $source $target     ; # copy 文件: cp $source $target  
file delete $path             ; # 删除文件 rm $path 
file delete --force $path     ; # 强制删除非空目录  rm -rf $path 
file rename $source $target   ; # mv $source $target  

# 获取链接(link)的最终目标文件
proc file_read_link {file} { 
	while {[file type $file] == "link"} 
	{
	set file [file join [file dirname $file] [file readlink $file]]
	}
	return $file 
}



