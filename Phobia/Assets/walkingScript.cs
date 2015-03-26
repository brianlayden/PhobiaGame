using UnityEngine;
using System.Collections;

public class walkingScript : MonoBehaviour {
	public GameObject player;
	public bool playerMove;
	public Camera playerCamera;
	public float moveSpeed = 0;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
		moveSpeed = moveSpeed / 1.04f;
		
		if (moveSpeed >= 35) {
			moveSpeed = 35;
		}
		if (Input.GetKeyDown (KeyCode.W) == true||Input.GetKeyDown(KeyCode.X)==true) {
			playerMove=true;
			moveSpeed+=8;
		} 
		
		
		
		if(playerMove==true) {
			player.transform.position +=playerCamera.transform.forward *(Time.deltaTime*moveSpeed);
		}
		
		
	}
}