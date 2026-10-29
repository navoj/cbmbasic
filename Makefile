OBJS=cbmbasic.o runtime.o plugin.o console.o
CFLAGS+=-Wall -O3
SDL?=0

ifeq ($(SDL),1)
SDL2_PKG_OK := $(shell pkg-config --exists sdl2 2>/dev/null && printf yes)
ifeq ($(SDL2_PKG_OK),)
$(error SDL=1 requires SDL2 development files and pkg-config; on Ubuntu/Debian install them with: sudo apt install libsdl2-dev pkg-config)
endif
SDL_CFLAGS=$(shell pkg-config --cflags sdl2)
SDL_LIBS=$(shell pkg-config --libs sdl2) -lm
CFLAGS += -DHAVE_SDL2 $(SDL_CFLAGS)
endif

OBJS += sdl_ui.o

all: cbmbasic

cbmbasic: $(OBJS)
	$(CC) $(LDFLAGS) -o cbmbasic $(OBJS) $(SDL_LIBS)

clean:
	rm -f $(OBJS) cbmbasic
