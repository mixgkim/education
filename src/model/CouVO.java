package model;

public class CouVO extends ProVO {
	private String lcode;
	private String lname;
	private String room;
	private int hours;
	private String persons;
	private String instructor;
	private int capacity;
	
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int i) {
		this.hours = i;
	}
	public String getPersons() {
		return persons;
	}
	public void setPersons(String string) {
		this.persons = string;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int i) {
		this.capacity = i;
	}
	
	@Override
	public String toString() {
		return "CouVO [lcode=" + lcode + ", lname=" + lname + ", room=" + room + ", hours=" + hours + ", persons="
				+ persons + ", instructor=" + instructor + ", capacity=" + capacity + "]";
	}
	

}
