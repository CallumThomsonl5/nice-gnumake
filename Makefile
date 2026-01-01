BUILD_DIR := build
SRC_DIR := src

SRCS := fuck.c shit.c lib/lib.c
SRCS := $(SRCS:%=$(SRC_DIR)/%)
OBJS := $(SRCS:$(SRC_DIR)%.c=$(BUILD_DIR)%.o)

CFLAGS += -Iinclude
LDFLAGS =

$(BUILD_DIR)/main: $(OBJS)
	@mkdir -p $(dir $@)
	@$(CC) $(LDFLAGS) $(OBJS) -o $(BUILD_DIR)/main
	$(info LD $(BUILD_DIR)/main)

-include $(OBJS:.o=.d)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c -o $@ -MMD -MF $(@:.o=.d) $<
	$(info CC $<)

clean:
	@rm -f $(OBJS) $(OBJS:.o=.d) $(BUILD_DIR)/main
	$(info cleaned)

