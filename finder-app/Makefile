CC  = $(CROSS_COMPILE)gcc
CFLAGS  = -Wall -DDEBUG -g

LDFLAGS = 
LDLIBS  = 

DEPS = 
OBJ = writer.o

# the build target executable:
TARGET = writer

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)

%.o : %.c $(DEPS)
	$(CC) $(CFLAGS) -o $@ -c $< 

.PHONY: clean

clean:
	rm -f $(TARGET)
	rm -f *.o *.bak *~*
