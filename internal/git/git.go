// Copyright (c) 2024 stefan <me@notstfn.lol>. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

package git

/*
#cgo pkg-config: --static ${SRCDIR}/../../external/libgit2/build/install/lib/pkgconfig/libgit2.pc

#include <git2.h>
*/
import "C"

// LibGit2Version returns the version of the libgit2 library being used.
func LibGit2Version() (major, minor, patch int) {
	cMajor, cMinor, cPatch := C.int(0), C.int(0), C.int(0)
	C.git_libgit2_version(&cMajor, &cMinor, &cPatch)
	return int(cMajor), int(cMinor), int(cPatch)
}
