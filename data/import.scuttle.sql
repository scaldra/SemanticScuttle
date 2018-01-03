-- Import users, bookmarks and tags from scuttle

INSERT INTO semanticscuttle.sc_users (uId, username, password, uDatetime, uModified, name, email, homepage, uContent)
  (SELECT *
   FROM
     scuttle.sc_users);

INSERT INTO semanticscuttle.sc_bookmarks (bId, uId, bIp, bStatus, bDatetime, bModified, bTitle, bAddress, bDescription, bHash)
  (SELECT
     bId,
     uId,
     bIp,
     bStatus,
     bDatetime,
     bModified,
     CONVERT(CONVERT(bTitle USING BINARY) USING utf8)       AS bTitle,
     bAddress,
     CONVERT(CONVERT(bDescription USING BINARY) USING utf8) AS bDescription,
     bHash
   FROM scuttle.sc_bookmarks);

INSERT INTO semanticscuttle.sc_bookmarks2tags
  (SELECT
     id,
     bId,
     CONVERT(CONVERT(tag USING BINARY) USING utf8)       AS tag
   FROM scuttle.sc_tags);

