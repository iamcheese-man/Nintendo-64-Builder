#include <libdragon.h>

int main(void) {
    display_init(RESOLUTION_320x240, DEPTH_32_BPP, 2, GAMMA_NONE, ANTIALIAS_RESAMPLE);
    console_init();

    printf("Hello, N64 World!\n");

    while(1) {
        display_show();
    }

    return 0;
}
