///////////////////////////////////////////////////////////////////////////////
// StdUtils plug-in for NSIS
// Copyright (C) 2004-2018 LoRd_MuldeR <MuldeR2@GMX.de>
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
//
// http://www.gnu.org/licenses/lgpl-2.1.txt
///////////////////////////////////////////////////////////////////////////////

#pragma once

wchar_t *ansi_to_utf16(const char *const input);
wchar_t *utf8_to_utf16(const char *const input);

char *utf16_to_utf8(const wchar_t *const input);
char *utf16_to_ansi(const wchar_t *const input);

char *ansi_to_utf8(const char *const input);
char *utf8_to_ansi(const char *const input);

char *strtrim(char *const input);
const char *strtrim_left(const char *const input);
char *strtrim_right(char *const input);

wchar_t *wcstrim(wchar_t *const input);
const wchar_t *wcstrim_left(const wchar_t *const input);
wchar_t *wcstrim_right(wchar_t *const input);

bool str_whitespace(const char c);
bool wcs_whitespace(const wchar_t c);

bool str_ascii_alpha(const char c);
bool wcs_ascii_alpha(const wchar_t c);

bool str_ascii_alnum(const char c);
bool wcs_ascii_alnum(const wchar_t c);

#ifdef UNICODE
	#define STRLEN wcslen	
	#define STRICMP _wcsicmp
	#define STRNICMP _wcsnicmp
	#define STRNCPY wcsncpy
	#define STRCHR wcschr
	#define STRTRIM wcstrim
	#define STRTRIM_LEFT wcstrim_left
	#define STRTRIM_RIGHT wcstrim_right
	#define SNPRINTF _snwprintf
	#define SSCANF swscanf
	#define ISCNTRL iswcntrl
	#define ISGRAPH iswgraph
	#define SPLITPATH _wsplitpath
	#define WHITESPACE wcs_whitespace
	#define STR_TO_UTF8 utf16_to_utf8
	#define UTF8_TO_STR utf8_to_utf16
	#define SETLOCALE _wsetlocale
	#define ASCII_ALNUM wcs_ascii_alnum
	#define ASCII_ALPHA wcs_ascii_alpha
	#define __T__(X) L##X
	#define T(X) __T__(X)
#else
	#define STRLEN strlen
	#define STRICMP _stricmp
	#define STRNICMP _strnicmp
	#define STRNCPY strncpy
	#define STRCHR strchr
	#define STRTRIM strtrim
	#define STRTRIM_LEFT strtrim_left
	#define STRTRIM_RIGHT strtrim_right
	#define SNPRINTF _snprintf
	#define SSCANF sscanf
	#define ISCNTRL iscntrl
	#define ISGRAPH isgraph
	#define SPLITPATH _splitpath
	#define WHITESPACE str_whitespace
	#define STR_TO_UTF8 ansi_to_utf8
	#define UTF8_TO_STR utf8_to_ansi
	#define SETLOCALE setlocale
	#define ASCII_ALNUM str_ascii_alnum
	#define T(X) X
#endif
