function get_line()
{
    filePath=$1
    lineNumber=$2
    head -n $lineNumber $filePath | tail -n 1
}

function delete_line()
{
   filePath=$1
   line=$2

   n=$(( $line -1 ))
   m=$(( $line +1 ))

   tempFile=.temp

   head $filePath -n $n > $tempFile
   tail $filePath -n +$m >> $tempFile

   mv $tempFile $filePath
}
