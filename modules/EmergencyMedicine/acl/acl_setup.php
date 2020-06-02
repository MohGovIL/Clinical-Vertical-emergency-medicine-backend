
<?php
// Ensure this script is not called separately
if ((empty($_SESSION['acl_setup_unique_id'])) ||
    (empty($unique_id)) ||
    ($unique_id != $_SESSION['acl_setup_unique_id'])) {
    die('Authentication Error');
}
unset($_SESSION['acl_setup_unique_id']);

use OpenEMR\Common\Acl\AclExtended;

//EXAMPLE
/* Vaccines groups */
$admin_write = AclExtended::getAclIdNumber('Administrators', 'write');

//Examples
//$imaging_technician_write =AclExtended::addNewACL('Imaging technician', 'imaging_technician', 'write', 'Things that imaging technician can modify');
//$imaging_technician_view =AclExtended::addNewACL('Imaging technician', 'imaging_technician', 'view', 'Things that imaging technician can read but not modify');
//AclExtended::addObjectSectionAcl('client_app', 'Client Application');
//AclExtended::addObjectAcl('client_app', 'Client Application', 'PatientTrackingInvited','Patient Tracking Invited');

?>
<html>
<head>
    <title>Imaging ACL Setup</title>
    <link rel=STYLESHEET href="interface/themes/style_blue.css">
</head>
<body>
<b>OpenEMR EmergencyMedicine ACL Setup</b>
<br>
All done configuring and installing access controls (php-GACL)!
</body>
</html>
