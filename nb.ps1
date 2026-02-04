#在后端日志中给变量添加[]是非常好的习惯(笑)
param
(
    [parameter(Mandatory=$true)]
    [string]$title
)
$folder_dir = "content/post/$title"
#这是给hugo看的非完整路径
$file_path = "post/$title/index.md"

if(Test-Path $folder_dir)
{
    Write-Host "warnig:文件夹" -NoNewline
    Write-Host "[$title]" -ForegroundColor Cyan -NoNewline
    Write-Host "已经存在了,请换个名字或者直接编辑." -ForegroundColor Yellow
    exit
}
Write-Host "正在创建文章包" -NoNewline
Write-Host "[$folder_dir]" -ForegroundColor Cyan
hugo new $file_path

$full_path = "$folder_dir/index.md"
if(Test-Path $full_path)
{
    Write-Host "成功,正在使用typora打开" -ForegroundColor Green
    typora $full_path
}
else
{
    Write-Host "未知错误退出" -ForegroundColor Red
}