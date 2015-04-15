using UnityEngine;
using System.Collections;

public class playerExitStartCave : MonoBehaviour {
	public Collider exitCollider;
	public Terrain theTerrain;
	public bool terrainEnabled = false;
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
				}
		if (exitCollider.name == "EnterCave2") {
			Debug.Log("Left Cave");
			terrainEnabled = !terrainEnabled;
			theTerrain.GetComponent<TerrainCollider> ().enabled = terrainEnabled;
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
