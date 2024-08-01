From: <Saved by Blink>
Snapshot-Content-Location: https://raw.githubusercontent.com/bassmadrigal/scripts/master/check-source-download.sh
Subject: 
Date: Wed, 31 Jul 2024 19:56:27 -0000
MIME-Version: 1.0
Content-Type: multipart/related;
	type="text/html";
	boundary="----MultipartBoundary--PqasMcCHvIhxVpR7T3sP31MZbW5SoIqUhOJrmKQwjO----"


------MultipartBoundary--PqasMcCHvIhxVpR7T3sP31MZbW5SoIqUhOJrmKQwjO----
Content-Type: text/html
Content-ID: <frame-CD69712708B88D0FC9DC9F1C96F98C01@mhtml.blink>
Content-Transfer-Encoding: quoted-printable
Content-Location: https://raw.githubusercontent.com/bassmadrigal/scripts/master/check-source-download.sh

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8"><link rel=3D"stylesheet" type=3D"text/css" href=3D"cid:css-006185=
92-25f9-4bb5-b964-b085e1c236ed@mhtml.blink" /></head><body><pre style=3D"wo=
rd-wrap: break-word; white-space: pre-wrap;">#!/bin/bash
#
# Copyright 2023-2024 Jeremy Hansen &lt;jebrhansen -at- gmail.com&gt;
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR IMPL=
IED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN N=
O
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED =
TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFIT=
S;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This was extracted and tweaked from my sbgen.sh script, which was added i=
n
# v0.6 in MAR 2023.

# This will take copy/pasted URLs from github and provide direct URLs that =
can
# download the correct filename with or without using content-disposition. =
It
# will also take hashed URLs from pythonhosted and pypi so all that is need=
ed
# to update versions is to change the version number.

# You can either add this function into your script, add it to your environ=
ment
# or pass the url to the script.

function check_download()
{
  TESTURL=3D"$1"
  DOMAIN=3D"$(echo "$TESTURL" | cut -d"/" -f 3)"

  # Let's first prep github addresses
  if [ "$DOMAIN" =3D=3D "github.com" ]; then
    OWNER=3D$(echo "$TESTURL" | cut -d"/" -f4)
    PROJECT=3D$(echo "$TESTURL" | cut -d"/" -f5)

    # Check for release urls, which don't need modification
    if [ "$(echo "$TESTURL" | cut -d"/" -f6)" =3D=3D "releases" ]; then
      NEWURL=3D"$TESTURL"
    # Catch tag versions
    elif [ "$(echo "$TESTURL" | cut -d"/" -f7-8)" =3D=3D "refs/tags" ]; the=
n
      # Extract the version from the URL to get the right tag and use that
      # to get the right version to include in the filename
      TAGVER=3D$(basename "$TESTURL" | rev | cut -d. -f3- | rev)
      NEWURL=3D"https://$DOMAIN/$OWNER/$PROJECT/archive/refs/tags/$TAGVER/$=
PROJECT-${TAGVER//v/ }.tar.gz"
    # Check for commit ID
    # Need to check for 41 chars since the url includes a newline that isn'=
t stripped
    elif [ "$(echo "$TESTURL" | cut -d"/" -f7 | cut -d"." -f1 | wc -m)" -eq=
 41 ]; then
      COMMITID=3D$(echo "$TESTURL" | cut -d"/" -f7 | cut -d"." -f1)
      NEWURL=3D"https://$DOMAIN/$OWNER/$PROJECT/archive/${COMMITID:0:7}/$PR=
OJECT-$COMMITID.tar.gz"
    # Just return the url if it doesn't match the above
    else
      NEWURL=3D"$TESTURL"
    fi

  # If we're using a hashed python.org link, switch to a proper versioned l=
ink
  elif [ "$DOMAIN" =3D=3D "files.pythonhosted.org" ] || [ "$DOMAIN" =3D=3D =
"pypi.python.org" ]; then
    # Check if we're using a hashed url by seeing if the parent folder is
    # 61 characters (the length of the hash)
    if [ "$(echo "$TESTURL" | cut -d"/" -f7 | wc -c)" =3D=3D "61" ]; then
      PROJECT=3D"$(echo "$TESTURL" | cut -d"/" -f8 | cut -d- -f1)"
      VERSION=3D"$(echo "$TESTURL" | cut -d"/" -f8 | cut -d- -f2 | rev | cu=
t -d"." -f3- )"
      NEWURL=3D"https://files.pythonhosted.org/packages/source/${PROJECT::1=
}/${PROJECT}/${PROJECT}-${VERSION}.tar.gz"
    else
      NEWURL=3D"$TESTURL"
    fi

  # Anything else, just ignore it.
  # Can add future catches if needed
  else
    NEWURL=3D"$TESTURL"
  fi

  # Return our correct URL
  echo "$NEWURL"
}

check_download "$1"
</pre></body></html>
------MultipartBoundary--PqasMcCHvIhxVpR7T3sP31MZbW5SoIqUhOJrmKQwjO----
Content-Type: text/css
Content-Transfer-Encoding: quoted-printable
Content-Location: cid:css-00618592-25f9-4bb5-b964-b085e1c236ed@mhtml.blink

@charset "utf-8";
=0A
------MultipartBoundary--PqasMcCHvIhxVpR7T3sP31MZbW5SoIqUhOJrmKQwjO------
