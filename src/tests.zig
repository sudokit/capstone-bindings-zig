test {
    _ = @import("impl.zig");
    _ = @import("ManagedHandle.zig");
    @import("std").testing.refAllDecls(@This());
}
