class NODE {
    data: number;
    next: NODE | null;

    constructor(value: number) {
        this.data = value;
        this.next = null;
    }
}

class LinkedList {
    head: NODE | null;

    constructor() {
        this.head = null;
    }

    insertEnd(value: number): void {
        const newNode = new NODE(value);

        if (this.head === null) {
            this.head = newNode;
            return;
        }

        let temp = this.head;

        while (temp.next !== null) {
            temp = temp.next;
        }

        temp.next = newNode;
    }

    printList(): void {
        let temp = this.head;

        while (temp !== null) {
            console.log("-->", temp.data);
            temp = temp.next;
        }

        console.log("NULL");
    }
}

const list = new LinkedList();
list.insertEnd(10);
list.insertEnd(20);
list.insertEnd(30);
list.insertEnd(40);
list.printList();
