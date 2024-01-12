# Schrippli
Quick static code analysis vulnerability scanner based on weggli and example queries from https://github.com/0xdea/weggli-patterns/blob/main/README.md.

**Disclaimer: Quick Proof-of-concept that was prototyped using GPT-4 in 10minutes. Don't use for anything meaningful. You have been warned.**


## Example

```bash
./schrippli.sh src/
[-] incorrect use of strncat (CWE-193, CWE-787): No issues found.
[!] destination buffer access using size of source buffer (CWE-806): Issues found:
src/test.c:1
int main() {
        strncat(blah, foo, strlen(foo));
        return 0;
}
[!] incorrect use of strncat (CWE-193, CWE-787): Issues found:
src/test.c:1
int main() {
        strncat(blah, foo, strlen(foo));
        return 0;
}
[!] lack of explicit NUL-termination after strncpy(), etc. (CWE-170): Issues found:
src/test.c:1
int main() {
        strncat(blah, foo, strlen(foo));
        return 0;
}
[-] use of sizeof() on a pointer type (CWE-467): No issues found.
[-] destination buffer access using size of source buffer (CWE-806): No issues found.
[-] incorrect use of strncat (CWE-193, CWE-787): No issues found.
[-] use of sizeof() on a pointer type (CWE-467): No issues found.
[-] incorrect use of strncat (CWE-193, CWE-787): No issues found.
[-] off-by-one error (CWE-193): No issues found.
[-] destination buffer access using size of source buffer (CWE-806): No issues found.
[-] use of sizeof() on a character constant: No issues found.
[-] off-by-one error (CWE-193): No issues found.
[-] off-by-one error (CWE-193): No issues found.
[-] use of sizeof() on a pointer type (CWE-467): No issues found.
```
