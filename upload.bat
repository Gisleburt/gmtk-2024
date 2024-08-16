@echo off

set butler="D:\Programs\butler\butler.exe"
set godot="D:\Programs\Godot\Godot_v4.3-stable_win64.exe"

::Find the current version
set find_text="config/version"
set find_file="godot-project\project.godot"

for /f "delims=" %%a in ('findstr %find_text% %find_file%') do set version_line=%%a
set version=%version_line:~16,-1%
set tag=v%version%

::Check version does not already exist

set /A found_tag = 0
for /f %%a in ('git tag -l %tag%') do set /A found_tag=1
if %found_tag% == 1 (
    echo Git Tag already used.
    echo Update version number in project and try again.
    exit 1
)

git tag %tag%
git push origin tag %tag%

::Check that Git repo is clean
set /A found_files = 0
for /f %%a in ('git status --porcelain') do set /A found_files=1
if %found_files% == 1 (
    echo Git is not clean.
    echo Commit all files and try again.
    exit 1
)

::Delete old files and recreate directories
if exist export\html rmdir /S /Q export\html
if not exist export mkdir export
if not exist export\html mkdir export\html

::Export project
%godot% --headless --export-release Web --path godot-project

::Publish to Itch
%butler% push export/html gisleburt/the-blat:HTML5 --userversion %version%
