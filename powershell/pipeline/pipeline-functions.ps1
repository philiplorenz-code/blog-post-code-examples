Filter Convert-ToUpperCase {
  Write-Output "Input in uppercase: $($_.ToUpper())"
}

"hello", "world" | Convert-ToUpperCase

############################################################

function Get-ModifiedFiles {
  param (
      [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
      [string]$Path,
      
      [datetime]$Since
  )
  
  process {
      $files = Get-ChildItem -Path $Path -Recurse | Where-Object { $_.LastWriteTime -gt $Since }
      $files
  }
}

"./" | Get-ModifiedFiles -Since (Get-Date).AddDays(-7)

############################################################

function Get-Size {
  param (
      [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
      [string]$Path
  )

  begin {
      # Initializing variables with a broader scope
      $totalSize = 0
      $tempDirectory = "./tmp"

      # Initialization: Creating temporary directory
      if (-not (Test-Path $tempDirectory)) {
          New-Item -Path $tempDirectory -ItemType Directory | Out-Null
      }
  }

  process {
      # Checking if the path exists and is a file
      if (Test-Path $Path -PathType Leaf) {
          $fileInfo = Get-Item $Path
          $fileSize = $fileInfo.Length
          $totalSize += $fileSize

          # Writing file information to a temporary file
          $outputPath = Join-Path $tempDirectory ($fileInfo.Name + ".txt")
          $fileInfo | Out-File $outputPath
      }
  }

  end {
      # Outputting the total size of all processed files
      Write-Output "Total size of all processed files: $($totalSize / 1MB) MB"
  }

  clean {
      # Deleting temporary directory
      Remove-Item $tempDirectory -Recurse -Force
  }
}

$files = @()
$files += "/Users/philip/Code/blog-post-code-examples/blog.docx"
$files += "/Users/philip/Code/blog-post-code-examples/image.dmg"
$files | Get-Size

############################################################

function Get-FileDetail {
    param (
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [string]$FullName
    )
    
    process {
        $fileInfo = Get-Item $FullName
        $fileDetail = @{
            Name = $fileInfo.Name
            Size = $fileInfo.Length
            LastModified = $fileInfo.LastWriteTime
        }
        $fileDetail
    }
}

Get-ChildItem -Path "./" | Get-FileDetail