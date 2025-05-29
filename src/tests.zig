test {
    _ = @import("impl.zig");
    @import("std").testing.refAllDecls(@This());
}
