package zooproject.Utils;

public enum TaskStatus {
    CHUA_THUC_HIEN(0),
    DANG_THUC_HIEN(1),
    HOAN_THANH(2);

    private final int value;

    TaskStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static TaskStatus fromValue(int value) {
        for (TaskStatus status : TaskStatus.values()) {
            if (status.getValue() == value) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown value: " + value);
    }
}
