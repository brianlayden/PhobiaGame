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

	void OnTriggerEnter(Collider exitCollider)
	{
		terrainEnabled = !terrainEnabled;
		theTerrain.GetComponent<TerrainCollider> ().enabled = terrainEnabled;
	}

}
