$latest_folder = Get-ChildItem "content/post" |
                Where-Object{ $_.PSIsContainer } |
                Sort-Object LastWriteTime -Descending |
                Select-Object -First 1
            
if($null -eq $latest_folder)
{
    Write-Host "[!] 未找到任何文章文件夹" -ForegroundColor Red
}

$blog_name = $latest_folder.Name

Write-Host "[*]检测到最近编辑的文章" -NoNewline
Write-Host "[$blog_name]" -ForegroundColor Cyan

Write-Host "正在准备上传到GitHub" -ForegroundColor Gray

git add .

$commit_message = "feat: update blog [$blog_name]"
git commit -m $commit_message
Write-Host "正在准备推送到远程仓库..." -ForegroundColor DarkYellow
git push
Write-Host "--------------------------------"
Write-Host "部署任务已交由 GitHub Actions 接管！" -ForegroundColor Green
Write-Host "请稍后访问你的博客地址查看更新。" -ForegroundColor Green
