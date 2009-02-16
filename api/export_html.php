<?php
// Implements the del.icio.us API request for all a user's posts, optionally filtered by tag.

// del.icio.us behavior:
// - doesn't include the filtered tag as an attribute on the root element (we do)

// Force HTTP authentication first!
require_once('httpauth.inc.php');
require_once('../header.inc.php');

/* Service creation: only useful services are created */
$bookmarkservice =& ServiceFactory::getServiceInstance('BookmarkService');

// Check to see if a tag was specified.
if (isset($_REQUEST['tag']) && (trim($_REQUEST['tag']) != ''))
    $tag = trim($_REQUEST['tag']);
else
    $tag = NULL;

// Get the posts relevant to the passed-in variables.
$bookmarks =& $bookmarkservice->getBookmarks(0, NULL, $userservice->getCurrentUserId(), $tag, NULL, getSortOrder());


// Set up the XML file and output all the posts.
echo '<!DOCTYPE NETSCAPE-Bookmark-file-1>'."\r\n";
echo '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">';
echo '<!-- This is an automatically generated file. -->'."\r\n";
echo '<TITLE>Bookmarks</TITLE>'."\r\n";
echo '<H1 LAST_MODIFIED="'. date('U') .'">Bookmarks for '. htmlspecialchars($currentUser->getUsername()) .''. (is_null($tag) ? '' : ' tag="'. htmlspecialchars($tag) .'"') ." from " . $sitename ."</H1>\r\n";
echo '<DL><p>'."\r\n";



foreach($bookmarks['bookmarks'] as $row) {
    if (is_null($row['bDescription']) || (trim($row['bDescription']) == ''))
        $description = '';
    else
        $description = 'description="'. filter($row['bDescription'], 'xml') .'" ';

    $taglist = '';
    if (count($row['tags']) > 0) {
        foreach($row['tags'] as $tag)
            $taglist .= convertTag($tag) .',';
        $taglist = substr($taglist, 0, -1);
    } else {
        $taglist = 'system:unfiled';
    }

    echo "\t<dt><a href=\"". filter($row['bAddress'], 'xml') .'" '. $description .' hash="'. md5($row['bAddress']) .'" tags="'. filter($taglist, 'xml') .'" ADD_DATE="'. date('U', strtotime($row['bDatetime'])) ."\" >" . filter($row['bTitle'], 'xml') ."</a>\r\n";
}


echo '</DL><p>';
?>
