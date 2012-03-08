TARGET=_wordseg.so
SOURCES=PrefixTree.cpp Segmenter.cpp wordseg.i
OBJECTS=wordseg_wrap.o wordseg.o PrefixTree.o Segmenter.o
INCLUDES=`python-config --includes`
# It depends on ICU 4.8.1 or 4.8.1.1 as it uses some internal API
LIBS=`python-config --libs` -L/usr/local/lib -licuuc -licudata
CFLAGS=-Os -fPIC
LDFLAGS=-shared

all::$(TARGET)

wordseg.o: wordseg.cpp wordseg.h Segmenter.h PrefixTree.h
	$(CXX) $(CFLAGS) $(INCLUDES) -c -o $@ $<

PrefixTree.o: PrefixTree.cpp PrefixTree.h
	$(CXX) $(CFLAGS) $(INCLUDES) -c -o $@ $<

Segmenter.o: Segmenter.cpp Segmenter.h PrefixTree.h
	$(CXX) $(CFLAGS) $(INCLUDES) -c -o $@ $<

wordseg_wrap.o: wordseg_wrap.cxx Segmenter.h PrefixTree.h
	$(CXX) $(CFLAGS) $(INCLUDES) -c -o $@ $<

wordseg_wrap.cxx: wordseg.i wordseg.h Segmenter.h PrefixTree.h
	swig -python -classic -c++ $<

$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LIBS)

clean::
	$(RM) $(OBJECTS) wordseg_wrap.cxx $(TARGET) wordseg.py *.pyc *.pyo

test::$(TARGET)
	python2.7 t.py
