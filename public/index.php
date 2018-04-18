<?php
/**
 * Some Test on init machine
 * User: alex_k
 */


// Create a temp file in the temporary
// files directory using sys_get_temp_dir()
$TmpFile = tempnam(sys_get_temp_dir(), 'TestFileForCheckTmp');
echo '<strong>Test tmp folder:</strong> ' . $TmpFile;

echo '<br>';

// PHP Information
phpinfo();