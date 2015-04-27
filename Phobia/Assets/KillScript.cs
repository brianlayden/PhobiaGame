using UnityEngine;
using System.Collections;

public class KillScript : MonoBehaviour {
	public GameObject player;
	public BoxCollider killPlane;
	public GameObject spawnPoint;
	public static bool playerDead = false;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider other)
	{
		if (other.name == "KillPlane") {
			playerDead = true;
			player.transform.position = spawnPoint.transform.position;
			playerDead=false;
			Debug.Log("Respawn");
				}
		}
}
