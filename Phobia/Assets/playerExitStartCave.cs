using UnityEngine;
using System.Collections;

public class playerExitStartCave : MonoBehaviour {
	public Collider exitCollider;
	public Terrain theTerrain;
	public bool terrainEnabled = false;
	public AudioSource windSound;
	public GameObject caveInRock;
	public AudioSource caveInSound;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerExit(Collider exitCollider)
	{
		if (exitCollider.name == "StartCave") {
						Debug.Log("Left Cave");
						terrainEnabled = !terrainEnabled;
						theTerrain.GetComponent<TerrainCollider> ().enabled = terrainEnabled;
			windSound.volume=1.0f;
				}

		if (exitCollider.name == "EnterCave2") {
			Debug.Log("Entered cave 2");
			terrainEnabled = !terrainEnabled;
			theTerrain.GetComponent<TerrainCollider> ().enabled = terrainEnabled;
			windSound.volume =.12f;
			caveInRock.GetComponent<CaveIn>().enabled=true;
			caveInSound.enabled=true;
		}
		if (exitCollider.name == "ExitCaveThree") {
			Debug.Log("Exit cave 3");
			terrainEnabled = !terrainEnabled;
			theTerrain.GetComponent<TerrainCollider> ().enabled = terrainEnabled;
			windSound.volume =.12f;
		}

	}

	void OnTriggerEnter(Collider exitCollider)
	{
		/*
		if (exitCollider.name == "ExitRockMesh") {
						terrainEnabled=!terrainEnabled;
						theTerrain.GetComponent<TerrainCollider> ().enabled = terrainEnabled;
				}
				*/

		}

}
