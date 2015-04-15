using UnityEngine;
using System.Collections;

public class firstCaveReenter : MonoBehaviour {
	// Use this for initialization
	public Terrain theTerrain;
	public SphereCollider caveCollider;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	/*
	void OnTriggerEnter(Collider caveCollider)
	{
		if (playerExitStartCave.terrainEnabled == true) 
		{
			playerExitStartCave.terrainEnabled=!playerExitStartCave.terrainEnabled;
			theTerrain.GetComponent<TerrainCollider> ().enabled = playerExitStartCave.terrainEnabled;
		}
	}
	*/
}
