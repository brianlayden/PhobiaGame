using UnityEngine;
using System.Collections;

public class CaveIn : MonoBehaviour {
	public GameObject caveRock;
	public Vector3 newCaveSpot = new Vector3(107.918f,88.954f,14.34f);
	// Use this for initialization
	void Start () {
		Debug.Log ("Rock fell");
	}
	
	// Update is called once per frame
	void Update () {
		caveRock.transform.position = Vector3.Lerp (caveRock.transform.position, newCaveSpot, Time.deltaTime);
	}
}
