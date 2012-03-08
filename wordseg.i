%module wordseg

%{
#include "wordseg.h"
%}

%include "std_string.i"
%include "std_vector.i"

%template(vectorstr) std::vector<std::string>;

%include "wordseg.h"
